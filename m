Received: from eggs.gnu.org ([2001:4830:134:3::10]:46742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9Hd4-0006F9-Va
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9Hd1-00042T-Ty
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:02:11 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9Hd1-000413-NR
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:02:07 -0400
Received: by mail-pf0-x244.google.com with SMTP id l27so3278608pfk.12
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 15:02:07 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-39-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <630e0846-4ac4-5ad0-d416-f0c7be2f836b@linaro.org>
Date: Thu, 19 Apr 2018 11:41:33 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-39-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 38/43] osdep: disable glib-compat.h
 include with QEMU_NO_GLIB
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
> To ease the cross-compilation of tests that do not use glib.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qemu/osdep.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
