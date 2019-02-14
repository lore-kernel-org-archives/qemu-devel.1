Received: from eggs.gnu.org ([209.51.188.92]:34807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDb2-0007FG-9S
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDb1-0006yv-JK
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:46:20 -0500
References: <20190207193605.25676-1-crosa@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <22e847da-14c5-f88b-19bc-a034d0eecf9e@vivier.eu>
Date: Thu, 14 Feb 2019 10:46:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190207193605.25676-1-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 0/4] Trivial fixes for
 configure and Python scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>

On 07/02/2019 20:36, Cleber Rosa wrote:
> This is just a small collection of trivial fixes for configure
> and some Python scripts (missing/unused import statements).
> 
> Cleber Rosa (4):
>   configure: remove handling of "wav" audio driver
>   configure: fix qemu-img name
>   scripts/render_block_graph.py: add a missing import
>   tests/migration/guestperf/engine.py: remove unused import
> 
>  configure                           | 6 +-----
>  scripts/render_block_graph.py       | 1 +
>  tests/migration/guestperf/engine.py | 1 -
>  3 files changed, 2 insertions(+), 6 deletions(-)
> 

I've applied to my trivial-patches branchi patches 1 and 2, but not 3
and 4 as I don't know python and no one has reviewed them.

Thanks,
Laurent
