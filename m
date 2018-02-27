Received: from eggs.gnu.org ([2001:4830:134:3::10]:55875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqkZq-0007gG-2M
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqkZp-00057D-3y
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:06:14 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-6-jsnow@redhat.com>
	<fbfc54ab-1aba-97e3-0779-7675133ada71@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <899da725-7058-878d-ef4c-20179b2b76d2@redhat.com>
Date: Tue, 27 Feb 2018 14:06:05 -0500
MIME-Version: 1.0
In-Reply-To: <fbfc54ab-1aba-97e3-0779-7675133ada71@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 05/21] blockjobs: add state transition
 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org



On 02/27/2018 01:58 PM, Eric Blake wrote:
> The ascii-art tables help in this and other patches.=C2=A0 Thanks for
> producing them.

Funny story: the original version of the STM present in these patches
was too complex and I was not able to draw a chart for them.

Kevin's insistence that I do draw a chart led to considerable slimming
of possible transitions.

--js
