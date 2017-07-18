Received: from eggs.gnu.org ([2001:4830:134:3::10]:54989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXUPs-0001SX-RV
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXUPs-0004o1-2x
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:28:04 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXUPr-0004mr-Ow
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:28:03 -0400
Received: by mail-wr0-x233.google.com with SMTP id w4so33412673wrb.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 08:28:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8B106629-58D8-49DC-8513-765D48A7E986@gmail.com>
References: <62C0BE33-631B-464C-96B4-3D83A4F8A305@gmail.com>
	<a7bd89bd-3b1c-b15a-f42a-5e33480a7135@redhat.com>
	<8B106629-58D8-49DC-8513-765D48A7E986@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 16:27:42 +0100
Message-ID: <CAFEAcA_h4aV+LDF5eDf6uPPuK-ofYvuOKJiKJx6bKokDL1rGhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Wiki documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 18 July 2017 at 16:21, Programmingkid <programmingkidx@gmail.com> wrote:
> I was wondering about that one. =E2=80=9Cconfigure =E2=80=94-help" doesn=
=E2=80=99t even list
> it. Just tried target-list=3Dhppa-softmmu, target-list=3Dhppa, and
> target-list=3Dhppa64-softmmu. None of them work. Would you have more
> information?

--target-list=3Dhppa-linux-user.

thanks
-- PMM
