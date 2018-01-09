Received: from eggs.gnu.org ([2001:4830:134:3::10]:59615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYwkB-0006CR-TC
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:27:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYwk8-0000OA-QD
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:27:19 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:37983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eYwk8-0000NT-Jt
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:27:16 -0500
Received: by mail-pf0-x241.google.com with SMTP id k19so1844003pfj.5
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 08:27:16 -0800 (PST)
References: <20180108180231.21122-1-f4bug@amsat.org>
	<20180108180231.21122-4-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6ce011e3-6730-87be-f86c-039f9b585a48@linaro.org>
Date: Tue, 9 Jan 2018 08:27:12 -0800
MIME-Version: 1.0
In-Reply-To: <20180108180231.21122-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/7] net/rocker: use QEMU_PACKED and
 QEMU_ALIGNED() macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel@nongnu.org

On 01/08/2018 10:02 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/net/rocker/rocker_hw.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
