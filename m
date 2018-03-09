Received: from eggs.gnu.org ([2001:4830:134:3::10]:56349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1euP3S-0000gS-I5
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:55:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1euP3R-0002L4-IR
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:55:54 -0500
Received: from mail-yw0-x235.google.com ([2607:f8b0:4002:c05::235]:46703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1euP3R-0002K3-DO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:55:53 -0500
Received: by mail-yw0-x235.google.com with SMTP id q184so1736335ywh.13
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 12:55:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f6993c0c-0314-b942-20ac-d697c2e41c27@vivier.eu>
References: <20180228221609.11265-1-jcmvbkbc@gmail.com>
	<20180228221609.11265-11-jcmvbkbc@gmail.com>
	<f6993c0c-0314-b942-20ac-d697c2e41c27@vivier.eu>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 9 Mar 2018 12:55:52 -0800
Message-ID: <CAMo8BfJyK6qBR3NRbMegqhgyrif03tZFujyQWzY+_Vs6XZGSTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/11] qemu-binfmt-conf.sh: add
 qemu-xtensa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

Hi Laurent,

On Fri, Mar 9, 2018 at 11:58 AM, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 28/02/2018 =C3=A0 23:16, Max Filippov a =C3=A9crit :
>> Register qemu-xtensa and qemu-xtensaeb for transparent linux userspace
>> emulation.
>>
>> Cc: Riku Voipio <riku.voipio@iki.fi>
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>> ---
>>  scripts/qemu-binfmt-conf.sh | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>
> Applied to my 'linux-user-for-2.12' branch.

could you please also take a look at the patch that adds xtensa linux-user
support:
  http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg07348.html

--=20
Thanks.
-- Max
