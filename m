Received: from eggs.gnu.org ([2001:4830:134:3::10]:47456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCZUU-0004SW-7y
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 20:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCZUR-0004K0-2Q
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 20:15:10 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCZUQ-0004GV-Iy
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 20:15:06 -0400
Received: by mail-pl1-x642.google.com with SMTP id q17-v6so11776754plr.8
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 17:15:06 -0700 (PDT)
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-14-aclindsa@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <81270d53-724b-000e-0bb8-da7ad761871e@linaro.org>
Date: Tue, 16 Oct 2018 17:15:02 -0700
MIME-Version: 1.0
In-Reply-To: <20181010203735.27918-14-aclindsa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 13/14] target/arm: Implement PMSWINC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aclindsa@gmail.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

On 10/10/18 1:37 PM, Aaron Lindsay wrote:
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/helper.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
