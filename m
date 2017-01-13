Received: from eggs.gnu.org ([2001:4830:134:3::10]:50311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRs3R-0004eZ-Ro
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 21:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRs3O-00021h-RN
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 21:57:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cRs3O-0001zd-LF
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 21:57:22 -0500
Date: Fri, 13 Jan 2017 10:57:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170113025711.GV4450@pxdev.xzpeter.org>
References: <1483428594-28880-1-git-send-email-peterx@redhat.com>
	<20170112162441-mutt-send-email-mst@kernel.org>
	<20170113021927.GT4450@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170113021927.GT4450@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH RFC v2 00/17] VT-d: vfio enablement and
 misc enhances
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Fri, Jan 13, 2017 at 10:19:27AM +0800, Peter Xu wrote:

[...]

> > This all looks good to me. The series needs to be
> > rebased on top of latest bits.
> > In particular, Jason made changes which conflict
> > with this.
> 
> Michael,
> 
> Thanks for your positive feedback.
> 
> Could you provide me a branch so that I can rebase this work on? I was
> trying to find a good base point in your repo here:
> 
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git
> 
> but failed to find a suitable branch. Thanks,

Please don't bother. Just noticed that Jason's patches related to VT-d
have been merged. So will rebase to master and re-post.

Thanks,

-- peterx
