Received: from eggs.gnu.org ([2001:4830:134:3::10]:45979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBet0-0003P3-B5
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBesx-0007yP-4K
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:44:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eBesw-0007y5-Tt
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:44:07 -0500
Date: Mon, 6 Nov 2017 10:44:01 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171106104401.GE23361@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171103153333.6416-1-berrange@redhat.com>
	<CAFEAcA-n7jLjBcCAG6r30F=UUZy8vAKfMK8oC3oM+K1QTsH0zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-n7jLjBcCAG6r30F=UUZy8vAKfMK8oC3oM+K1QTsH0zA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Various improvements/bugfixes to
 submodule handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Fri, Nov 03, 2017 at 06:03:55PM +0000, Peter Maydell wrote:
> On 3 November 2017 at 15:33, Daniel P. Berrange <berrange@redhat.com> wrote:
> > This short series of patches improves the reliability of the submodule
> > handling to cope with various dev env scenarios that have since emerged
> 
> Can I ask you to write up a bit for the release notes at
> https://wiki.qemu.org/ChangeLog/2.11#Build_Information
> covering what users need to know about the new submodule
> handling, please?

Certainly, will do that.

Perhaps have something in the general wiki pages about building QEMU, and
link to it from the changelog.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
