Received: from eggs.gnu.org ([2001:4830:134:3::10]:54137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWPtz-00011F-JH
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWPty-00037y-Vz
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:58:59 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:38438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWPty-00037e-Qy
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:58:58 -0500
Received: by mail-pl0-x243.google.com with SMTP id s10so28973125plj.5
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 08:58:58 -0800 (PST)
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-13-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1690ebf8-e547-4e77-378b-6038aba9bcb3@linaro.org>
Date: Tue, 2 Jan 2018 08:58:54 -0800
MIME-Version: 1.0
In-Reply-To: <20180102011032.30056-13-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 12/17] target/m68k: implement
 fsave/frestore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/01/2018 05:10 PM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
