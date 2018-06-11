Received: from eggs.gnu.org ([2001:4830:134:3::10]:33973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fSOGi-0003km-22
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fSOGe-0000fV-Vn
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:58:04 -0400
Date: Mon, 11 Jun 2018 16:57:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180611165755.64b684c8.cohuck@redhat.com>
In-Reply-To: <20180611141716.3813-1-peter.maydell@linaro.org>
References: <20180611141716.3813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] CODING_STYLE: Define our preferred form
 for multiline comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, patches@linaro.org, Richard Henderson <rth@twiddle.net>, John Snow <jsnow@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Alex Williamson <alex.williamson@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Mon, 11 Jun 2018 15:17:16 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> The codebase has a bit of a mix of different multiline
> comment styles. State a preference for the Linux kernel
> style:
>     /*
>      * Star on the left for each line.
>      * Leading slash-star and trailing star-slash
>      * each go on a line of their own.
>      */
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is not my personal favourite, but seemed to be the
> closest we had to consensus in the mail thread for v1;
> I can live with it in order to avoid getting patches which
> use the styles I like even less :-)
> ---
>  CODING_STYLE | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
