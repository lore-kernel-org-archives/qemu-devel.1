Received: from eggs.gnu.org ([2001:4830:134:3::10]:54958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWPvM-00024G-18
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:00:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWPvL-000490-0y
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:00:24 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:38534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWPvK-000481-I5
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:00:22 -0500
Received: by mail-pg0-x243.google.com with SMTP id t67so2810431pgc.5
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 09:00:22 -0800 (PST)
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-14-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f9de6b8c-b2fd-8257-b3d6-c6b9f2e35831@linaro.org>
Date: Tue, 2 Jan 2018 09:00:18 -0800
MIME-Version: 1.0
In-Reply-To: <20180102011032.30056-14-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 13/17] target/m68k: move CCR/SR functions
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
> The following patches will be clearer if we move
> functions before adding new ones.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 111 ++++++++++++++++++++++++------------------------
>  1 file changed, 55 insertions(+), 56 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
