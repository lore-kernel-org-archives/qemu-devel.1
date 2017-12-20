Received: from eggs.gnu.org ([2001:4830:134:3::10]:33633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1eRgtx-0001pm-M2
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1eRgtn-0004Pd-IM
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:07:25 -0500
References: <20171220130815.20708-1-laurent@vivier.eu>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <b99e47fa-458f-9e62-4074-ac689464c4e6@tuxfamily.org>
Date: Wed, 20 Dec 2017 17:06:30 +0100
MIME-Version: 1.0
In-Reply-To: <20171220130815.20708-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: remove unused variable
 gen_throws_exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 20.12.2017 14:08, Laurent Vivier wrote:
> It has been introduced by e6e5906b6e ("ColdFire target."),
> but the content is never used.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 10 ----------
>  1 file changed, 10 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>
