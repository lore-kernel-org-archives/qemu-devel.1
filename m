Received: from eggs.gnu.org ([2001:4830:134:3::10]:47491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fUHC8-0006Jj-8A
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 15:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fUHC5-0000xm-4V
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 15:49:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54158 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fUHC4-0000xZ-VR
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 15:49:05 -0400
References: <20180615194705.28019-1-alex.bennee@linaro.org>
	<20180615194705.28019-14-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e44e4356-a3d9-6b9a-8dd5-870292f248d7@redhat.com>
Date: Sat, 16 Jun 2018 21:48:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180615194705.28019-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 13/54] tests/tcg/multiarch: move most
 output to stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org

On 15.06.2018 21:46, Alex Benn=C3=A9e wrote:
> The default test run outputs to stdout so it can be re-directed.
> Errors are still reported to stderr.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Thomas Huth <thuth@redhat.com>
