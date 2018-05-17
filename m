Received: from eggs.gnu.org ([2001:4830:134:3::10]:47780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJMne-0008DY-Dj
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJMna-00045t-GF
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:34:46 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:33335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJMna-00045c-9d
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:34:42 -0400
Received: by mail-pg0-x231.google.com with SMTP id v7-v6so2146486pgs.0
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:34:42 -0700 (PDT)
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-36-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9e6a126f-4fc8-15a9-1b11-e1d3d6dba691@linaro.org>
Date: Thu, 17 May 2018 10:34:38 -0700
MIME-Version: 1.0
In-Reply-To: <20180516185146.30708-36-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 35/38] target-microblaze: Convert
 env_btarget to i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

On 05/16/2018 11:51 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Convert env_btarget to i64.
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---

I thought you were going to drop this one?


r~
