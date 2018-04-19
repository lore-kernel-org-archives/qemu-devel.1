Received: from eggs.gnu.org ([2001:4830:134:3::10]:43090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9GnK-00080V-39
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9GnF-00045X-DB
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:08:42 -0400
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:33973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9GnF-00044K-7h
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:08:37 -0400
Received: by mail-pl0-x22a.google.com with SMTP id z12-v6so3971118plo.1
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:08:37 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0fdc1c9e-8b9f-bce9-630f-c166be189245@linaro.org>
Date: Thu, 19 Apr 2018 11:08:31 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/43] docker: Makefile.include
 introduce DOCKER_SCRIPT
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
> Define this in one place to make it easy to re-use.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/docker/Makefile.include | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
