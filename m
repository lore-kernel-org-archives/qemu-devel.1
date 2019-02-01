Received: from eggs.gnu.org ([209.51.188.92]:38821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gpfCM-00026v-7F
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 15:14:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gpfCL-0007Ne-Hp
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 15:14:02 -0500
Date: Fri, 1 Feb 2019 15:13:40 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190201201340.GA20601@flamenco>
References: <20190201193234.20796-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201193234.20796-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests: Ignore fp test outputs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, alex.bennee@linaro.org

On Fri, Feb 01, 2019 at 13:32:34 -0600, Eric Blake wrote:
> Commit 2cade3d wired up new tests, but did not exclude the
> new *.out files produced by running the tests.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
