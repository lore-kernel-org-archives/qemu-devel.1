Received: from eggs.gnu.org ([2001:4830:134:3::10]:54872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEIg3-0007vA-Pi
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEIfz-0004rN-3B
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:33:11 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cEIfy-0004rE-Nl
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:33:07 -0500
Received: by mail-vk0-f54.google.com with SMTP id w194so198483421vkw.2
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 08:33:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <efd2e5b9-ec59-f747-6cec-0a8ceaaffa5d@redhat.com>
References: <2011630530.2430235.1481039230635.JavaMail.zimbra@redhat.com>
	<e8c1ed6f-fc4b-2093-60d8-5a2fb4f22e5e@redhat.com>
	<efd2e5b9-ec59-f747-6cec-0a8ceaaffa5d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Dec 2016 16:31:45 +0000
Message-ID: <CAFEAcA8ccJa3feOwpREKn3jkSnUEvCrPMrKN9B8s7gd4umN+mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] ui/egl-helpers.c license and reuse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Frediano Ziglio <fziglio@redhat.com>, Qemu-devel <qemu-devel@nongnu.org>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Cole Robinson <crobinso@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 6 December 2016 at 16:24, Eric Blake <eblake@redhat.com> wrote:
> Markus Armbruster also has a one-line deletion (although how can a line
> no longer present in the file be holding up a copyright question?). It
> depends on whether you use 'git blame' to track all contributors to the
> current state of the file, or 'git log' to track all authors to any
> changes to the file.  'git blame' may also come in handy if you only
> need to copy a subset of the file.

The only change I made to it was an automated scripted one to
add the #include "qemu/osdep.h", so if that's not in the code
you want then you probably don't need to involve me/Linaro.

thanks
-- PMM
