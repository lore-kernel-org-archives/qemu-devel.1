Received: from eggs.gnu.org ([2001:4830:134:3::10]:57084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXDkq-0006zg-JX
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 18:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXDko-0003yf-BP
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 18:45:08 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:44768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXDko-0003xy-62
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 18:45:06 -0400
Received: by mail-pl0-x241.google.com with SMTP id m16-v6so1113748pls.11
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 15:45:06 -0700 (PDT)
References: <20180622141205.16306-1-alex.bennee@linaro.org>
	<20180622141205.16306-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <528feb2f-10e2-5acd-485e-fe3dc8afed17@linaro.org>
Date: Sun, 24 Jun 2018 15:45:02 -0700
MIME-Version: 1.0
In-Reply-To: <20180622141205.16306-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v4 09/22] risugen: use fewer insns for
 aarch64 immediate load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 06/22/2018 07:11 AM, Alex Bennée wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  risugen_arm.pm | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)

Ho hum,
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


r~
