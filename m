Received: from eggs.gnu.org ([2001:4830:134:3::10]:49888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQi3N-00052H-DE
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 18:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQi3M-0001CH-Kj
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 18:36:49 -0400
Date: Thu, 29 Jun 2017 18:36:47 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170629223647.GE9797@flamenco>
References: <149873841036.9180.16600465902334229930.stgit@frigg.lan>
	<149874010452.9180.5182724462159161565.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149874010452.9180.5182724462159161565.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v10 7/7] trace: [trivial] Statically enable
 all guest events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, "open list:Trivial patches" <qemu-trivial@nongnu.org>

On Thu, Jun 29, 2017 at 15:41:44 +0300, Lluís Vilanova wrote:
> The existing optimizations makes it feasible to have them available on all
> builds.
(snip)
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  trace-events |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
