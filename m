Received: from eggs.gnu.org ([2001:4830:134:3::10]:41544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cORbf-0001sA-H9
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cORbc-0000gg-Ct
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:06:35 -0500
Date: Tue, 3 Jan 2017 16:06:29 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170103160629.GH14707@stefanha-x1.localdomain>
References: <1482896059-12020-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Content-Disposition: inline
In-Reply-To: <1482896059-12020-1-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [Resend PATCH] The QEMU crashes since invoking
 qemu_thread_set_name(), the backtrace is:
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Caoxinhua <caoxinhua@huawei.com>, arei.gonglei@huawei.com, pbonzini@redhat.com, herongguang.he@huawei.com


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Please follow the conventions for commit messages.  QEMU commit messages
start with a prefix that identifies the affected component.

(Use git-log(1) to check what prefix other people have used for the
file(s) you touched.)

The commit message should be brief and doesn't need to be a full
sentence.

For example:

  qemu-thread: fix qemu_thread_set_name() race in qemu_thread_create()

Thanks,
Stefan

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYa8wFAAoJEJykq7OBq3PIsGMH/1mEeXiZn/W2vCdLewwtEBA1
fLMEV92JvzpqOm3v4XSNGJmLxmf8HTeSVAueCVPtLei8p3nBAC7QmBt49SSkfz8A
UcgV/j6XY0HmUQcTrK7BBvsEZWC9lzxhMGUt05LgPHiJOgTylxSDDSz/BCqqvYKA
IdkhKUQoxZ1wlQLLwwWj2WZpC5CQofFiWbkAKX6DCdisss1CcB8y+1KgUQb2IeBO
AOCDMLBsFaYhAb3SJ8Lp2QrZt6cOURJ3kknmlqIkp621XmGO2OAI0mgmj220EewU
C/FtGsHwoUVtm4bmNKNUU06LIRsWcDvWVNLakTOEdyuUY28pA+HcJvQET0/L03A=
=spUn
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
