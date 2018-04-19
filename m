Received: from eggs.gnu.org ([2001:4830:134:3::10]:34230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9HJ6-0005ws-1q
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9HJ2-0002Ir-Tr
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:41:32 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:42356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9HJ2-0002I4-MW
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:41:28 -0400
Received: by mail-pg0-x244.google.com with SMTP id e12so3099837pgn.9
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:41:28 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-40-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ee98710b-e1fb-16e7-964f-8ccdf9af403c@linaro.org>
Date: Thu, 19 Apr 2018 11:41:23 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-40-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 39/43] softfloat: do not include glib
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/19/2018 03:58 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> To ease the cross-compilation of softfloat.o.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  fpu/softfloat.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
