Received: from eggs.gnu.org ([2001:4830:134:3::10]:45127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dg9rl-0000sz-GN
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dg9rg-00050o-9i
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:20:41 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:34444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dg9rg-00050Y-3d
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:20:36 -0400
Received: by mail-pf0-x231.google.com with SMTP id o86so15887219pfj.1
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 06:20:36 -0700 (PDT)
References: <20170811074652.31474-1-david@redhat.com>
	<20170811074652.31474-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c673ee2b-373a-9001-c955-b045ec858558@linaro.org>
Date: Fri, 11 Aug 2017 06:20:31 -0700
MIME-Version: 1.0
In-Reply-To: <20170811074652.31474-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 5/5] target/s390x: cleanup cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com

On 08/11/2017 12:46 AM, David Hildenbrand wrote:
> Let's reshuffle the function prototypes so we get a cleaner outline
> of the files.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h | 140 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 70 insertions(+), 70 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
