package
{
	[Bindable]
	public class EmbedResources {
		public function EmbedResources() {
		}
		
		[Embed(source="assets/images/top_banner.png")]
		public static const topBannerImg:Class;

		[Embed(source="assets/images/t_b.jpg")]
		public static const topBImg:Class;		
	}
}