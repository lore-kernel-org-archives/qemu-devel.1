Received: from eggs.gnu.org ([208.118.235.92]:54278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfRFz-0008PH-BJ
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:19:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfRFy-0000cx-OY
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:19:31 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfRFt-0000Xx-Ad
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:19:28 -0500
Received: by mail-oi1-x241.google.com with SMTP id y1so30602604oie.12
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 07:19:21 -0800 (PST)
MIME-Version: 1.0
References: <1546433583-18397-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1546433583-18397-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 15:19:09 +0000
Message-ID: <CAFEAcA9wbunFqSobxU49dtOm=ajgcraxHV5NqKHeNtHsiccgYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add ARM-related files for
 hw/[misc|input|timer]/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

On Wed, 2 Jan 2019 at 12:53, Thomas Huth <thuth@redhat.com> wrote:
>
> Some of the files in hw/input/, hw/misc/ and hw/timer/ are only
> used by one of the ARM machines, so we can assign these files to
> the corresponding boards.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>


Applied to target-arm.next, thanks.

-- PMM
