Received: from eggs.gnu.org ([2001:4830:134:3::10]:57003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZNsh-0002Th-AE
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZNsc-0001Ng-Ia
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:25:55 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZNsc-0001Mn-1N
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:25:50 -0500
Received: by mail-pg0-x243.google.com with SMTP id j2so590314pgv.3
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 13:25:49 -0800 (PST)
References: <20180108231048.23966-1-laurent@vivier.eu>
	<20180108231048.23966-6-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8d04471b-5d60-1d5c-a2e1-b93a2b91d944@linaro.org>
Date: Wed, 10 Jan 2018 13:25:45 -0800
MIME-Version: 1.0
In-Reply-To: <20180108231048.23966-6-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] target/m68k: add pflush/ptest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On 01/08/2018 03:10 PM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/cpu.h       |  3 +++
>  target/m68k/helper.c    | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
>  target/m68k/helper.h    |  2 ++
>  target/m68k/monitor.c   |  1 +
>  target/m68k/op_helper.c |  1 +
>  target/m68k/translate.c | 33 +++++++++++++++++++++++
>  6 files changed, 112 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
