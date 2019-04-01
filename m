Received: from eggs.gnu.org ([209.51.188.92]:35038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hAwt9-0008J1-Iz
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hAwt8-0005P7-Cj
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:22:11 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:44914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hAwt7-0005Mr-2i
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:22:10 -0400
Received: by mail-wr1-x42e.google.com with SMTP id y7so11988087wrn.11
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 06:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190401092612.9658-1-aruna.15@cse.mrt.ac.lk>
	<623ecf54-40ad-c811-8b60-41d82f99c778@redhat.com>
In-Reply-To: <623ecf54-40ad-c811-8b60-41d82f99c778@redhat.com>
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Mon, 1 Apr 2019 18:51:54 +0530
Message-ID: <CAH95U0jQuR5OLFf_8rk9VfZvyGAmvbwqHphaPopqhrWDP-guGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Header cleanups for functions
 declared in utils/ files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

Thanks for the feedback! I have recreated the patch according to Daniels
suggestions by separating the modifications.

On Mon, 1 Apr 2019 at 18:25, Eric Blake <eblake@redhat.com> wrote:

> On 4/1/19 4:26 AM, Aruna Jayasena wrote:
> > Declarations were moved out of qemu-common.h for functions declared in
> utils/ files.
> > This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
> >
> > Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> >
> > ---
>
> Thanks for working on this! Some hints for better reviews:
>
> - you sent a series, but did not include a 0/2 cover letter; our
> automated CI tools do best when there is a cover letter
>
> - you did not describe how v2 differs from v1; here after the --- is a
> good spot to mention it, to help reviewers double-check your changes from
> v1
>
> More patch submission hints can be found at
> https://wiki.qemu.org/Contribute/SubmitAPatch
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>

--=20
*Aruna* Jayasena
Embedded Systems and Computer Science Engineering Undergraduate
University of Moratuwa
*=E2=9C=86 **+94719872152 *
=E2=9C=89 <aruna.15@cse.mrt.ac.lk> =E2=8C=A8 <http://archfx.github.io> in
<https://www.linkedin.com/in/arunajayasena/>
