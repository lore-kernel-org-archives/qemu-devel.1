Received: from eggs.gnu.org ([2001:4830:134:3::10]:59845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d1zGa-0005Q4-PQ
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 13:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d1zGX-0000Co-Om
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 13:56:16 -0400
References: <1490360147-26450-1-git-send-email-fred.konrad@greensocs.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <8f9aadab-b728-e4ec-095d-5734a268c239@msgid.tls.msk.ru>
Date: Sat, 22 Apr 2017 20:56:12 +0300
MIME-Version: 1.0
In-Reply-To: <1490360147-26450-1-git-send-email-fred.konrad@greensocs.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ppc_booke: drop useless assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fred.konrad@greensocs.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

24.03.2017 15:55, fred.konrad@greensocs.com wrote:
> From: KONRAD Frederic <fred.konrad@greensocs.com>
> 
> The tb_env variable is set two lines above. So just drop the double assignment.

Applied to -trivial, thanks!

/mjt
