Received: from eggs.gnu.org ([2001:4830:134:3::10]:57808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXDpL-0008Q4-Bt
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 18:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXDpG-0006Fj-LF
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 18:49:47 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXDpG-0006FN-Ff
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 18:49:42 -0400
Received: by mail-pf0-x241.google.com with SMTP id b17-v6so5552641pfi.0
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 15:49:42 -0700 (PDT)
References: <20180622141205.16306-1-alex.bennee@linaro.org>
	<20180622141205.16306-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c0f433b6-b3ac-7554-2497-0ceb305b9eed@linaro.org>
Date: Sun, 24 Jun 2018 15:49:38 -0700
MIME-Version: 1.0
In-Reply-To: <20180622141205.16306-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v4 10/22] risugen: add reg_plus_imm_pl
 and reg_plus_imm_vl address helpers
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
>  risugen_arm.pm | 126 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


r~
