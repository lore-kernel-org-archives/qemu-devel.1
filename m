Received: from eggs.gnu.org ([2001:4830:134:3::10]:46023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e7hBq-0002L5-D4
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e7hBm-0003Vp-9k
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:23:14 -0400
References: <20170630183736.13222-1-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1b8ff383-9d0b-d178-cd76-8c3b48aaead8@redhat.com>
Date: Thu, 26 Oct 2017 14:22:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170630183736.13222-1-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: Use
 tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org

On 30.06.2017 20:37, Richard Henderson wrote:
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/ppc/translate.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)

*ping*

Richard, David, any chance that we can still get this in for 2.11? I
think this would be quite a nice performance improvement for PPC TCG...

 Thomas
