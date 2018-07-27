Received: from eggs.gnu.org ([2001:4830:134:3::10]:53784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fj1HO-0002wI-49
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 07:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fj1HL-00019y-2B
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 07:51:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36800 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fj1HK-00019W-Rz
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 07:51:26 -0400
Date: Fri, 27 Jul 2018 14:51:18 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180727144726-mutt-send-email-mst@kernel.org>
References: <1514626559-162312-1-git-send-email-longpeng2@huawei.com>
	<1514626559-162312-2-git-send-email-longpeng2@huawei.com>
	<fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
	<5B51CF0B.8020706@huawei.com>
	<a332a516-16dc-1e50-3ea6-b68571880cb7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a332a516-16dc-1e50-3ea6-b68571880cb7@linux.ibm.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [v23 1/2] virtio-crypto: Add
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Longpeng (Mike)" <longpeng2@huawei.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, virtio-dev@lists.oasis-open.org, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, wangxinxin.wang@huawei.com, liang.j.ma@intel.com, jasowang@redhat.com, xin.zeng@intel.com, qemu-devel@nongnu.org, john.griffin@intel.com, agraf@suse.de, arei.gonglei@huawei.com, stefanha@redhat.com, jianjay.zhou@huawei.com, cornelia.huck@de.ibm.com, Varun.Sethi@freescale.com, Jani.Kokkonen@huawei.com, vincent.jardin@6wind.com, denglingli@chinamobile.com, weidong.huang@huawei.com

On Thu, Jul 26, 2018 at 06:55:44PM +0200, Halil Pasic wrote:
> Sorry I did not have any time for this last days. And this
> to make it worse this is a follow up to something that was
> half a year ago. That means I have to re-familiarize myself
> with the topic.
> 
> If I don't get around to answer in couple of weeks, feel
> free to ping me.
> 
> Since from what I've seen most of the questions were of type
> 'Can we do it like this?', maybe sending out a new version
> is the best. So people (like me) can read through the whole
> thing and point out problems if any.
> 
> Regards,
> Halil


While two weeks for review is borderline reasonable as an exception, it
does trouble me that  we are at v23, for something that is used
in the field so it's not like we can just change things at will.
So I hope everyone concerned makes an effort to try to converge on a spec
ASAP.

> On 07/20/2018 02:01 PM, Longpeng (Mike) wrote:
> > 
> > 
> > On 2018/1/10 1:05, Halil Pasic wrote:
> > 
> > > 
> > > 
> > > On 12/30/2017 10:35 AM, Longpeng(Mike) wrote:
> > > > From: Gonglei <arei.gonglei@huawei.com>
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
