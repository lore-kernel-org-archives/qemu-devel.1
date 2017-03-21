Received: from eggs.gnu.org ([2001:4830:134:3::10]:52620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqKKv-0003O7-NZ
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqKKv-0006Ek-26
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:00:33 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cqKKu-0006Ef-S6
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:00:32 -0400
Received: by mail-wm0-x236.google.com with SMTP id n11so13184125wma.0
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 07:00:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490079888-29029-1-git-send-email-kraxel@redhat.com>
References: <1490079888-29029-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Mar 2017 14:00:11 +0000
Message-ID: <CAFEAcA_+p+oSymWxq_21zu8KQNSPX3JWnY1kt0GawgJJFxj8ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] add opengl_cflags to QEMU_CFLAGS
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

On 21 March 2017 at 07:04, Gerd Hoffmann <kraxel@redhat.com> wrote:
> ... and drop OPENGL_CFLAGS from Makefiles.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  configure                | 2 +-
>  hw/display/Makefile.objs | 6 +-----
>  ui/Makefile.objs         | 7 ++-----
>  3 files changed, 4 insertions(+), 11 deletions(-)
>

Applied to master, thanks.

-- PMM
