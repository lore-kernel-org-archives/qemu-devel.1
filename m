Received: from eggs.gnu.org ([2001:4830:134:3::10]:48841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZNcL-0003a2-5z
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZNcH-0002wJ-U4
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:09:01 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZNcH-0002vY-Lv
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:08:57 -0500
Received: by mail-pg0-x242.google.com with SMTP id i196so527467pgd.0
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 13:08:57 -0800 (PST)
References: <20180108231048.23966-1-laurent@vivier.eu>
	<20180108231048.23966-4-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dcf0ffed-6746-3927-986b-c747f172d6fd@linaro.org>
Date: Wed, 10 Jan 2018 13:08:53 -0800
MIME-Version: 1.0
In-Reply-To: <20180108231048.23966-4-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] target/m68k: add Transparent
 Translation
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
> Add ittr0, ittr1, dttr0, dttr1 and manage Transparent Translations
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/cpu.h       | 18 +++++++++++
>  target/m68k/helper.c    | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
>  target/m68k/monitor.c   |  4 +++
>  target/m68k/translate.c |  3 ++
>  4 files changed, 104 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
