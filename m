Received: from eggs.gnu.org ([2001:4830:134:3::10]:59066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPpTK-0007Yo-83
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPpTJ-0004m7-DN
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:56:46 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gPpTI-0004ik-Vd
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:56:45 -0500
Received: by mail-oi1-x242.google.com with SMTP id a77so7524245oii.5
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 05:56:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1542782568-20059-1-git-send-email-thuth@redhat.com>
References: <1542782568-20059-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Nov 2018 13:56:23 +0000
Message-ID: <CAFEAcA_zeAgAcsVX3=4ZVOxp6Vye7irNABrdzad1HQOMHo6cBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] MAINTAINERS: Assign some more files in
 the hw/arm/ directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On 21 November 2018 at 06:42, Thomas Huth <thuth@redhat.com> wrote:
> I apparently missed some more files and even a complete machine (the
> "imx25-pdk") in my previous patch... but now we should hopefully have
> a completely coverage for all available ARM boards.
>
> Fixes: 95a5db3ae5698b49c63144610ad02913e780c828
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v3: Dropped "ds1338-test.c", added some more pxa2xx related files instead
>
>  MAINTAINERS | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>

Applied to target-arm.next for 3.1, thanks.

(or have my
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
if you'd rather it go in some other way.)

-- PMM
