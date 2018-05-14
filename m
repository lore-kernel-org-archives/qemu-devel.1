Received: from eggs.gnu.org ([2001:4830:134:3::10]:51438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIJ7r-0006WH-Jl
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIJ7q-0008Sy-S4
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:27:15 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-5-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0d657a44-5c44-34b4-6e95-bcd7427c027f@redhat.com>
Date: Mon, 14 May 2018 15:27:09 -0400
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/42] blockjob: Implement
 block_job_set_speed() centrally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com



On 05/09/2018 12:25 PM, Kevin Wolf wrote:
> All block job drivers support .set_speed and all of them duplicate the
> same code to implement it. Move that code to blockjob.c and remove the
> now useless callback.

=F0=9F=8E=8A

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
