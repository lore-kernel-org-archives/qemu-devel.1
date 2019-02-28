Received: from eggs.gnu.org ([209.51.188.92]:50009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzOXs-0001Mm-M5
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzOXr-0008VZ-IO
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:28:28 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:44553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzOXq-0008Sh-RV
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:28:27 -0500
Received: by mail-pf1-x42b.google.com with SMTP id a3so9944434pff.11
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 08:28:26 -0800 (PST)
References: <1551356875-30676-1-git-send-email-thuth@redhat.com>
	<1551356875-30676-10-git-send-email-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eab2ac82-2b97-c7e6-cced-0141aac16cf6@linaro.org>
Date: Thu, 28 Feb 2019 08:28:22 -0800
MIME-Version: 1.0
In-Reply-To: <1551356875-30676-10-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 09/13] MAINTAINERS: Add maintainer to the
 TCG/i386 subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 2/28/19 4:27 AM, Thomas Huth wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Richard obviously maintains this subdirectory, make this official :)
> 
> Remove the qemu-devel@nongnu.org entry because the list is always
> selected by the 'All patches CC here' section.
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

s/rth@twiddle.net/richard.henderson@linaro.org/

I do this as part of my day job.  With that,

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~
