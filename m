Received: from eggs.gnu.org ([2001:4830:134:3::10]:43706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1fwWfe-0003o7-85
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 14:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1fwWfb-0006AO-1o
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 14:00:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1fwWfa-00069u-Pk
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 14:00:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2-v6so15619063wrw.7
	for <qemu-devel@nongnu.org>; Sun, 02 Sep 2018 11:00:18 -0700 (PDT)
References: <20180902123608.124586-1-ybettan@redhat.com>
From: Yoni Bettan <ybettan@redhat.com>
Message-ID: <8ec8993a-f4c6-eba3-a23a-68d798a83907@redhat.com>
Date: Sun, 2 Sep 2018 21:00:16 +0300
MIME-Version: 1.0
In-Reply-To: <20180902123608.124586-1-ybettan@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/4] Reformatted INFO files to fit the
 Markdown (.md) format.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com

Please ignore this message as a V2 was already sent.


Thanks,

Yoni.


On 9/2/18 3:36 PM, Yoni Bettan wrote:
> This patch make INFO files (e.g. README, CODING_STYLE etc) much more
> readable when watched from GitHub GUI.
>
> ./VERSION and ./MAINTAINERS were leave untouched otherwise
> ./scripts/get_maintainer.pl breaks.
>
> ./COPYING and ./COPYING.LIB were leave untouched because it look likes
> they come from GNU and not QEMU.
>
> Visualization of the change can be found at
> https://github.com/ybettan/qemu/tree/md.
> NOTE:
> This last part of the message should be removed from the commit message
> since I will remove the 'md' brance from my fork if the patch is
> accepted.
>
> Yoni Bettan (4):
>    README.md : Reformatted to fit the Markdown (.md) format.
>    CODING_STYLE.md : Reformatted to fit the Markdown (.md) format.
>    HACKING.md : Reformatted to fit the Markdown (.md) format.
>    LICENSE.md : Reformatted to fit the Markdown (.md) format.
>
>   CODING_STYLE => CODING_STYLE.md | 151 ++++++++++++++------------
>   HACKING => HACKING.md           | 186 +++++++++++++++++---------------
>   LICENSE => LICENSE.md           |   4 +-
>   README => README.md             |  87 +++++++--------
>   4 files changed, 224 insertions(+), 204 deletions(-)
>   rename CODING_STYLE => CODING_STYLE.md (50%)
>   rename HACKING => HACKING.md (53%)
>   rename LICENSE => LICENSE.md (90%)
>   rename README => README.md (68%)
>
