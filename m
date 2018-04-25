Received: from eggs.gnu.org ([2001:4830:134:3::10]:37905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB7ww-0007yC-T4
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB7wu-0002uu-80
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:06:18 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:33072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fB7wu-0002uk-23
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:06:16 -0400
Received: by mail-pf0-x22f.google.com with SMTP id f15so13610682pfn.0
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 17:06:15 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1085f22e-7a13-9870-5d80-9004232e8ba6@linaro.org>
Date: Tue, 24 Apr 2018 14:06:10 -1000
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 02/46] configure: add test for docker
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

On 04/24/2018 05:23 AM, Alex Bennée wrote:
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
