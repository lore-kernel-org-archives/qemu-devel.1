Received: from eggs.gnu.org ([2001:4830:134:3::10]:41215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fLPE8-00033O-Fn
	for qemu-devel@nongnu.org; Wed, 23 May 2018 04:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fLPE5-0005Rm-BT
	for qemu-devel@nongnu.org; Wed, 23 May 2018 04:34:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37646 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fLPE5-0005Rf-7A
	for qemu-devel@nongnu.org; Wed, 23 May 2018 04:34:29 -0400
Date: Wed, 23 May 2018 16:34:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180523083426.GL28114@lemon.usersys.redhat.com>
References: <20180521103504.26432-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180521103504.26432-1-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] tests/docker/Makefile.include: handle
 empty TARGET_LIST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Mon, 05/21 11:35, Alex Benn=E9e wrote:
> If the user doesn't specify a TARGET_LIST they get the current
> configuration but with spaces and hilarity ensues. This adds some make
> magic to turn the TARGET_LIST back into a comma separated list.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

Queued, thanks!

Fam
