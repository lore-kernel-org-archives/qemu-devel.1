Received: from eggs.gnu.org ([209.51.188.92]:55008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqYh-00054X-G3
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqYd-0003OG-OL
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:50:07 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLqYa-0003Mm-9E
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:50:01 -0400
Received: by mail-pf1-x441.google.com with SMTP id 10so8712541pfo.5
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:49:59 -0700 (PDT)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6b54a7c9-c455-c1d5-371a-de67ad517c9f@linaro.org>
Date: Wed, 1 May 2019 07:49:56 -0700
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 14/15] Makefile: include per-target
 build directories in coverage report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org

On 4/30/19 9:52 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
