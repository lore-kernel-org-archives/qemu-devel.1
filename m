Received: from eggs.gnu.org ([2001:4830:134:3::10]:59906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYwkc-0006WB-Mi
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:27:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYwka-0000wf-4Q
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:27:46 -0500
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:43765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eYwkZ-0000vm-Vq
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:27:44 -0500
Received: by mail-pf0-x235.google.com with SMTP id e3so8895386pfi.10
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 08:27:43 -0800 (PST)
References: <20180108180231.21122-1-f4bug@amsat.org>
	<20180108180231.21122-5-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e4f692ec-84e0-6fd7-61cc-1c7a69b1bb19@linaro.org>
Date: Tue, 9 Jan 2018 08:27:39 -0800
MIME-Version: 1.0
In-Reply-To: <20180108180231.21122-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/7] net/rocker: move struct rocker_desc to
 C file
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
> this is the only user.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/net/rocker/rocker_hw.h   | 13 -------------
>  hw/net/rocker/rocker_desc.c | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
