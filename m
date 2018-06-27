Received: from eggs.gnu.org ([2001:4830:134:3::10]:49684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYBbW-0005L1-JQ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYBbS-0003KP-RK
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:39:30 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:45949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYBbS-0003JV-Le
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:39:26 -0400
Received: by mail-pf0-x243.google.com with SMTP id a22-v6so1061098pfo.12
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 07:39:26 -0700 (PDT)
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-43-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <77701561-fead-eeea-2184-6a45aa7deafa@linaro.org>
Date: Wed, 27 Jun 2018 07:39:22 -0700
MIME-Version: 1.0
In-Reply-To: <20180625124238.25339-43-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 42/46] monitor: Use the IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, Eric Blake <eblake@redhat.com>
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

On 06/25/2018 05:42 AM, Philippe Mathieu-Daudé wrote:
> It eases code review, unit is explicit.
> 
> Patch generated using:
> 
>   $ git grep -n '[<>][<>]= ?[1-5]0'
> 
> and modified manually.
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  monitor.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
