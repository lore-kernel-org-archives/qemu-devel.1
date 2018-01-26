Received: from eggs.gnu.org ([2001:4830:134:3::10]:51845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ef4F4-0000L7-9D
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ef4Ez-0002Na-Dr
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:40:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ef4EO-00021i-Nn
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:40:24 -0500
Date: Fri, 26 Jan 2018 13:39:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180126133944.GE1556@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAJSP0QWfwAbQwDUH3-e87+fB+FLPjJT3tXjQcDpPrxf7Rk-0cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QWfwAbQwDUH3-e87+fB+FLPjJT3tXjQcDpPrxf7Rk-0cw@mail.gmail.com>
Subject: Re: [Qemu-devel] QEMU related blogs, all in once place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, Jan 26, 2018 at 09:52:21AM +0000, Stefan Hajnoczi wrote:
> If you want to follow blogs from QEMU contributors check out:
> 
> https://planet.virt-tools.org/
> 
> Daniel Berrange has provided the following steps for adding your own
> blog to planet.virt-tools.org:
> 
>   $ git clone git://libvirt.org/virttools-planet.git
> 
> and add your blog info to updater/virt-tools/config.ini.
> 
> Optionally add a icon in updater/virt-tools/images/.
> 
> Then send the changes as a patch to libvir-list@redhat.com with
> git send-email.

Thanks for promoting this Stefan.

As the URL suggests, we are not merely looking for QEMU or libvirt developer's
blogs. We're interested in blogs from anyone who is involved in the open source
virtualization toools stack, xen, qemu, kvm, libvirt, spice, libguestfs,
virt-install, etc, etc, and likes writing blogs about it. Doesn't have to be
all raw tech details either, just as important are people writing user facing
blog content.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
