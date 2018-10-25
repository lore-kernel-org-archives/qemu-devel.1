Received: from eggs.gnu.org ([2001:4830:134:3::10]:40930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFgCa-0002wR-UB
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFgCI-0002Xo-QA
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:01:25 -0400
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-8-crosa@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <34917edc-d40f-e4f7-0093-acd892815642@vivier.eu>
Date: Thu, 25 Oct 2018 14:59:50 +0100
MIME-Version: 1.0
In-Reply-To: <20181004161852.11673-8-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 07/10]
 scripts/decodetree.py: remove unused imports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Max Reitz <mreitz@redhat.com>

On 04/10/2018 17:18, Cleber Rosa wrote:
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/decodetree.py | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 277f9a9bba..457cffea90 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -149,12 +149,10 @@
>  #   trans_addl_i(ctx, &arg_opi, insn)
>  #
>  
> -import io
>  import os
>  import re
>  import sys
>  import getopt
> -import pdb
>  
>  insnwidth = 32
>  insnmask = 0xffffffff
> 

Applied

Thanks,
Laurent
