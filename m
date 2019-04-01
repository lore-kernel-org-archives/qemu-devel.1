Received: from eggs.gnu.org ([209.51.188.92]:56527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hApSa-0007b5-L0
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 01:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hApSZ-0002er-M1
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 01:26:16 -0400
References: <20190401024406.10819-1-jbi.octave@gmail.com>
	<20190401024406.10819-3-jbi.octave@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <255e505d-56c3-cd02-8061-491be5783342@redhat.com>
Date: Mon, 1 Apr 2019 07:26:10 +0200
MIME-Version: 1.0
In-Reply-To: <20190401024406.10819-3-jbi.octave@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] util: readline: replace tab indent
 by four spaces to fix checkpatch errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jules Irenge <jbi.octave@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 01/04/2019 04.44, Jules Irenge wrote:
> Replace tab indent by four spaces to fix errors issued by checkpatch.pl tool
> "ERROR: code indent should never use tabs" within "util/readline.c" file.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  util/readline.c | 98 ++++++++++++++++++++++++-------------------------
>  1 file changed, 49 insertions(+), 49 deletions(-)
Reviewed-by: Thomas Huth <thuth@redhat.com>
