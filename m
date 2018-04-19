Received: from eggs.gnu.org ([2001:4830:134:3::10]:48042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f94UN-0000Rf-0l
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f94UD-0007rG-SP
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:00:19 -0400
Date: Thu, 19 Apr 2018 08:59:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180419075958.GD10259@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418144538.4aa2f492.cohuck@redhat.com>
	<20180418125545.GN27579@redhat.com>
	<87sh7rvf27.fsf@dusky.pond.sub.org>
	<20180419093024.27c77433.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180419093024.27c77433.olaf@aepfle.de>
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Apr 19, 2018 at 09:30:24AM +0200, Olaf Hering wrote:
> Am Thu, 19 Apr 2018 09:19:28 +0200
> schrieb Markus Armbruster <armbru@redhat.com>:
> 
> > > [1]   https://libvirt.org/platforms.html  
> > This policy looks sensible to me
> 
> Unless I misinterpret that, noone cares about SLE11 anymore.

I wouldn't say people don't care about SLE11 (or other similarly old distros
like RHEL-6). Rather the view in libvirt was that if a user is stuck on such
an old distro, they are likely doing that because they want the stability
inherant in running fixed software versions for years. IOW it is unlikely
that they want the stability of an old distro, combined with cutting edge
libvirt and/or QEMU.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
