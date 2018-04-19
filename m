Received: from eggs.gnu.org ([2001:4830:134:3::10]:34407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9GVH-00084Y-RJ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9GVE-0005kR-Q0
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:50:03 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:45782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9GVE-0005hU-Jj
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:50:00 -0400
Received: by mail-pg0-x22f.google.com with SMTP id i29so1541239pgn.12
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 13:50:00 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <51cc5786-b371-8dd2-4080-5d65a32cb902@linaro.org>
Date: Thu, 19 Apr 2018 10:49:55 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 02/43] configure: add test for docker
 availability
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
> This tests for a working docker installation without sudo and sets up
> config-host.mak accordingly. This will be useful from cross compiling
> things in the future.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
