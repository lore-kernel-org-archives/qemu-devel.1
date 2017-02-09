Received: from eggs.gnu.org ([2001:4830:134:3::10]:43796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cbqMS-0001uT-Qd
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cbqMP-0006Is-2r
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:10:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cbqMO-0006IX-Ta
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:10:13 -0500
Date: Thu, 9 Feb 2017 15:10:11 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170209151011.GB26192@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <KcWe8GG--3-0@tutanota.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <KcWe8GG--3-0@tutanota.com>
Subject: Re: [Qemu-devel] Error on OpenBSD/macppc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthias Freitag <matthias.freitag@tutanota.com>
Cc: qemu-devel@nongnu.org

On Thu, Feb 09, 2017 at 07:56:20AM +0100, Matthias Freitag wrote:
> (qemu) unknown keycodes `macintosh_aliases(qwerty)', please report
> to qemu-devel@nongnu.org
> 
> Which i am doing with this email :)

Thanks !

Could you tell us a few extra bits of info

 - What X server are you running on your client desktop ?

 - What keyboard layout are you using ? I'm guessing a plain
   US ascii like layout from that keycode name

 - Do all key presses generate the correct results in the
   guest OS, particularly for non-alpha numeric keys ?
   ie does '#' cause '#' to appear in the guest.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
