Received: from eggs.gnu.org ([2001:4830:134:3::10]:34349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g8Jnw-0007Xc-3g
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 02:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g8Jnv-00078o-9A
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 02:41:39 -0400
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-3-crosa@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <12fa0c81-ddb2-3012-faeb-03fae5950e44@redhat.com>
Date: Fri, 5 Oct 2018 08:41:28 +0200
MIME-Version: 1.0
In-Reply-To: <20181004161852.11673-3-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/10] tests/tcg/README: fix location for
 lm32 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>

On 2018-10-04 18:18, Cleber Rosa wrote:
> Point to the right and obvious location for lm32 tests.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/tcg/README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/README b/tests/tcg/README
> index a5643d33e7..2a58f9a058 100644
> --- a/tests/tcg/README
> +++ b/tests/tcg/README
> @@ -10,6 +10,6 @@ with "make test-cris".
>  
>  LM32
>  ====
> -The testsuite for LM32 is in tests/tcg/cris.  You can run it
> +The testsuite for LM32 is in tests/tcg/lm32.  You can run it
>  with "make test-lm32".

Reviewed-by: Thomas Huth <thuth@redhat.com>
