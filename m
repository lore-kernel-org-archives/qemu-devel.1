Received: from eggs.gnu.org ([2001:4830:134:3::10]:39147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ce2VW-0002rr-NE
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:32:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ce2VT-0007se-4F
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:32:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ce2VS-0007sZ-Un
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:32:39 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C61838DF11
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 16:32:38 +0000 (UTC)
Date: Wed, 15 Feb 2017 16:32:32 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170215163232.GL24672@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <06BE8A21-A1E9-4264-BD02-04A566748633@redhat.com>
	<173cba42-5390-0e16-71a3-3eadcd3ef654@redhat.com>
	<9657908C-A71B-424E-BBFD-E4A8EEF1C178@redhat.com>
	<416ddd00-7348-a7c7-54c0-6f0754e7d062@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <416ddd00-7348-a7c7-54c0-6f0754e7d062@redhat.com>
Subject: Re: [Qemu-devel] VirtIO Windows Driver repository
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Cole Robinson <crobinso@redhat.com>

On Wed, Feb 15, 2017 at 05:27:59PM +0100, Laszlo Ersek wrote:
> On 02/15/17 16:15, Yan Vugenfirer wrote:
> > 
> >> On 14 Feb 2017, at 16:08, Laszlo Ersek <lersek@redhat.com> wrote:
> >>
> >> On 02/14/17 13:40, Yan Vugenfirer wrote:
> >>> Hello All,
> >>>
> >>> The official upstream repository moved from
> >>> https://github.com/YanVugenfirer/kvm-guest-drivers-windows to
> >>> https://github.com/virtio-win/kvm-guest-drivers-windows
> >>>
> >>> Best regards, Yan Vugenfirer.
> >>
> >> Thanks! I've updated the corresponding reference under
> >> <https://fedoraproject.org/wiki/Windows_Virtio_Drivers#Links>.
> > 
> > Thanks!
> > 
> > Do you know who can make a change on
> > http://www.linux-kvm.org/page/WindowsGuestDrivers/Repository ?
> 
> I thought that I had page editing permissions, and indeed when I edit
> the page and hit "Save", I'm presented with the updated version.
> However, as soon as I re-visit the page, the old version is shown, and I
> can't find my changes in the page history either.
> 
> Dan, can you pls help?

I'm not admin for the KVM wiki - try Jeff Cody iirc


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
