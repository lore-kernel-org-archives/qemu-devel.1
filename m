Received: from eggs.gnu.org ([209.51.188.92]:55914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hApPk-0006AM-Rm
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 01:23:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hApPj-00011O-Uv
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 01:23:20 -0400
References: <20190401024406.10819-1-jbi.octave@gmail.com>
	<20190401024406.10819-2-jbi.octave@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <acd65b38-9a74-cd43-0841-b5da0f5fcc5b@redhat.com>
Date: Mon, 1 Apr 2019 07:23:12 +0200
MIME-Version: 1.0
In-Reply-To: <20190401024406.10819-2-jbi.octave@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] util/readline: add a space to fix
 errors by checkpatch tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jules Irenge <jbi.octave@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 01/04/2019 04.44, Jules Irenge wrote:
> util/readline: add a space to fix errors reported by checkpatch.pl tool
> "ERROR: space required before the open parenthesis"
> "ERROR: space required after that ..."
> within "util/redline.c" file
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  util/readline.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
