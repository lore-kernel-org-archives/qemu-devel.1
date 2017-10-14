Received: from eggs.gnu.org ([2001:4830:134:3::10]:55807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e3JD4-0006ZV-8b
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 05:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e3JD3-0000DT-Lx
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 05:58:22 -0400
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-2-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c0988952-236b-a31b-5d63-bd1f0642f8dd@vivier.eu>
Date: Sat, 14 Oct 2017 11:58:02 +0200
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 01/30] linux-user/main: support dfilter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Le 13/10/2017 à 18:24, Alex Bennée a écrit :
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 829f974662..5072aa855b 100644

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
