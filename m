Received: from eggs.gnu.org ([209.51.188.92]:34945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2YK0-0007Ng-SG
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2YK0-0000hh-2I
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:31:12 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:39045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h2YJz-0000gz-M9
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:31:12 -0500
References: <20190306031221.GA53@03612eec87fc>
	<20190306043658.GA75@03612eec87fc>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4c98e312-0827-2946-be6e-1aad18cc8771@vivier.eu>
Date: Sat, 9 Mar 2019 10:30:46 +0100
MIME-Version: 1.0
In-Reply-To: <20190306043658.GA75@03612eec87fc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/10] qemu-binfmt-conf.sh: enforce safe
 style consistency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, eblake@redhat.com

On 06/03/2019 05:36, Unai Martinez-Corral wrote:
> Spaces are added before '; then', for consistency.
> 
> All the tests are prefixed with 'x', in order to avoid risky comparisons
> (i.e. a user deliberately trying to provoke a syntax error).
> 
> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> ---
>  scripts/qemu-binfmt-conf.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
