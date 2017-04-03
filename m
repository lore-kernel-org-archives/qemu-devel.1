Received: from eggs.gnu.org ([2001:4830:134:3::10]:41770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cv6Sh-00085e-AD
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cv6Se-000053-5T
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:12:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cv6Sd-0008VO-VP
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:12:16 -0400
References: <1980722825.15261554.1491163199130.ref@mail.yahoo.com>
	<1980722825.15261554.1491163199130@mail.yahoo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b0e2ad51-afd8-01d7-39a4-8a87be1a15ac@redhat.com>
Date: Mon, 3 Apr 2017 14:12:13 -0400
MIME-Version: 1.0
In-Reply-To: <1980722825.15261554.1491163199130@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Raspberry PI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Bradley <flypie1@yahoo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Bradley <flypie@rocketmail.com>



On 04/02/2017 03:59 PM, John Bradley via Qemu-devel wrote:
> Hi,
> I've just pulled together a collection of patches from various sources to get the Raspberry PI emulation working on the March 27 source. Is it worth sending it in as a patch for inclusion. It allows some of the Circle low level demo to run.
> 
> 
>  John BradleyTel: 07896 839635Skype: flypie125 125B Grove StreetEdge Hill Liverpool L7 7AF
> 

If you are willing to commit to the review process of upstreaming this
code and creating revisions and so on, please do send patches!

If you're feeling like you're already done with the project, it may
still be useful to get a link to a git tree so others can at least see
the code, but without a steward they'll almost certainly not get merged.

--js
