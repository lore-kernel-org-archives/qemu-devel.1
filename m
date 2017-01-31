Received: from eggs.gnu.org ([2001:4830:134:3::10]:45939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYbCw-0000pz-37
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYbCv-0001Ab-BN
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:02 -0500
Received: from mail-vk0-x236.google.com ([2607:f8b0:400c:c05::236]:35631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYbCv-0001AM-7j
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:01 -0500
Received: by mail-vk0-x236.google.com with SMTP id x75so240397747vke.2
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 08:23:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
References: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jan 2017 16:22:40 +0000
Message-ID: <CAFEAcA9MbE1QwcXaxOEot4J0+Fua8mXOG-KoxQOdcD4vWmwcsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/11] ui patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 31 January 2017 at 15:50, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here comes the ui patch queue.  Nothing outstanding here.  Bugfixes and
> small improvements all user interfaces.
>
> v2 updates:
>   * change "C.utf-8" locale to "C.UTF-8".

> Kevin Wolf (1):
>       gtk: Hardcode LC_CTYPE as C.utf-8

...commit message no longer matches change.

thanks
-- PMM
